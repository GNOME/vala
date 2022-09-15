# SPDX-FileCopyrightText: 2021 GNOME Foundation
#
# SPDX-License-Identifier: CC0-1.0

# Configuration file for the Sphinx documentation builder.

import os

# -- Project information -----------------------------------------------------

project = 'Vala Reference Manual'
copyright = '2006-2023, The Vala Project'
author = 'The Vala Project'
version = os.environ['VERSION']
release = version

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
]
source_suffix = {
    '.rst': 'restructuredtext'
}

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []

html_title = 'Vala Reference Manual'

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'furo'
html_theme_options = {
    "light_css_variables": {
        "color-brand-primary": "#A56DE2",
        "color-brand-content": "#A56DE2",
    },
    "dark_css_variables": {
        "color-brand-primary": "#A56DE2",
        "color-brand-content": "#A56DE2",
    }
}

# add custom files that are stored in _static
html_css_files = ['gnome.css']

html_logo = 'logo.png'
html_favicon = 'logo.png'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

#footer stuff
html_show_copyright = 0
html_show_sphinx = 0
show_source = 0

