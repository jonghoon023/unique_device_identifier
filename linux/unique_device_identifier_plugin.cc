#include "include/unique_device_identifier/unique_device_identifier_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <unistd.h>
#include <fstream>
#include <string>
#include <cstring>
#include <algorithm>

#include "unique_device_identifier_plugin_private.h"

#define UNIQUE_DEVICE_IDENTIFIER_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), unique_device_identifier_plugin_get_type(), \
                              UniqueDeviceIdentifierPlugin))

struct _UniqueDeviceIdentifierPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(UniqueDeviceIdentifierPlugin, unique_device_identifier_plugin, g_object_get_type())

std::string get_machine_id() {
  std::ifstream file("/etc/machine-id");
  std::string id;
  if (file.is_open()) {
    std::getline(file, id);
    file.close();
    id.erase(
      std::remove_if(id.begin(), id.end(), [](char c) {
        return std::isspace(static_cast<unsigned char>(c));
      }),
      id.end()
    );
  }
  return id;
}

static void unique_device_identifier_plugin_handle_method_call(
    UniqueDeviceIdentifierPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "get_unique_identifier") == 0) {
    std::string machine_id = get_machine_id();
    if (!machine_id.empty()) {
      g_autoptr(FlValue) result = fl_value_new_string(machine_id.c_str());
      response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    } else {
      response = FL_METHOD_RESPONSE(fl_method_error_response_new("UNAVAILABLE", "Unable to read /etc/machine-id", nullptr));
    }
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void unique_device_identifier_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(unique_device_identifier_plugin_parent_class)->dispose(object);
}

static void unique_device_identifier_plugin_class_init(UniqueDeviceIdentifierPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = unique_device_identifier_plugin_dispose;
}

static void unique_device_identifier_plugin_init(UniqueDeviceIdentifierPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  UniqueDeviceIdentifierPlugin* plugin = UNIQUE_DEVICE_IDENTIFIER_PLUGIN(user_data);
  unique_device_identifier_plugin_handle_method_call(plugin, method_call);
}

void unique_device_identifier_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  UniqueDeviceIdentifierPlugin* plugin = UNIQUE_DEVICE_IDENTIFIER_PLUGIN(
      g_object_new(unique_device_identifier_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "unique_device_identifier",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
