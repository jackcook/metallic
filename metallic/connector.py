import objc, os

framework_path = os.path.join(os.path.dirname(__file__), "..", "framework", "Metallic.framework")

__bundle__ = objc.initFrameworkWrapper("Metallic",
    frameworkIdentifier="com.jackcook.Metallic",
    frameworkPath=framework_path,
    globals=globals())
