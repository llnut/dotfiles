register /home/sora/.dotfiles/bin/nushell/nu_plugin_query  {
  "sig": {
    "name": "query",
    "usage": "Show all the query commands",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "vectorizes_over_list": false,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_type": "Any",
    "output_type": "Any",
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

register /home/sora/.dotfiles/bin/nushell/nu_plugin_query  {
  "sig": {
    "name": "query json",
    "usage": "execute json query on json file (open --raw <file> | query json 'query string')",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [
      {
        "name": "query",
        "desc": "json query",
        "shape": "String",
        "var_id": null,
        "default_value": null
      }
    ],
    "optional_positional": [],
    "rest_positional": null,
    "vectorizes_over_list": false,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_type": "Any",
    "output_type": "Any",
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

register /home/sora/.dotfiles/bin/nushell/nu_plugin_query  {
  "sig": {
    "name": "query web",
    "usage": "execute selector query on html/web",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "vectorizes_over_list": false,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "query",
        "short": "q",
        "arg": "String",
        "required": false,
        "desc": "selector query",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "as-html",
        "short": "m",
        "arg": null,
        "required": false,
        "desc": "return the query output as html",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "attribute",
        "short": "a",
        "arg": "String",
        "required": false,
        "desc": "downselect based on the given attribute",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "as-table",
        "short": "t",
        "arg": "Table",
        "required": false,
        "desc": "find table based on column header list",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "inspect",
        "short": "i",
        "arg": null,
        "required": false,
        "desc": "run in inspect mode to provide more information for determining column headers",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_type": "Any",
    "output_type": "Any",
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Network"
  },
  "examples": []
}

register /home/sora/.dotfiles/bin/nushell/nu_plugin_query  {
  "sig": {
    "name": "query xml",
    "usage": "execute xpath query on xml",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [
      {
        "name": "query",
        "desc": "xpath query",
        "shape": "String",
        "var_id": null,
        "default_value": null
      }
    ],
    "optional_positional": [],
    "rest_positional": null,
    "vectorizes_over_list": false,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_type": "Any",
    "output_type": "Any",
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

