# 2026-04-23T10:15:33.584927200
import vitis

client = vitis.create_client()
client.set_workspace(path="SW")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../../rp_top.xsa",os = "standalone",cpu = "microblaze_I",domain_name = "standalone_microblaze_I",compiler = "gcc")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_microblaze_I",template = "hello_world")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

vitis.dispose()

