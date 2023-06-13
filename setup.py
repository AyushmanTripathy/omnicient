from setuptools import setup, find_packages


setup(
    name='omnicient',
    version='1.0',
    license='MIT',
    author="Ayushman Tripathy",
    author_email='ayushmantripathy2004@gmail.com',
    packages=find_packages('src'),
    package_dir={'': 'src'},
    url='https://github.com/AyushmanTripathy/omnicient',
    keywords='google webscraping searching',
    install_requires=['BeautifulSoup4'],
)
