from setuptools import setup

setup(name="metallic",
      version="0.1",
      description="Metal-accelerated framework for scientific computing",
      url="http://github.com/jackcook/metallic",
      author="Jack Cook",
      author_email="hello@jackcook.com",
      license="MIT",
      packages=["metallic"],
      install_requires=["pyobjc"],
      zip_safe=False)
