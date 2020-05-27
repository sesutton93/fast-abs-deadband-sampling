from setuptools import setup, find_packages
import numpy
from Cython.Build import cythonize
setup(
    name="fast Absolute Deadband Sampling",
    packages=["fads"],
    ext_modules = cythonize("fads/*.pyx", 
                            compiler_directives={'language_level': 3}),
    include_dirs=[numpy.get_include()]
)