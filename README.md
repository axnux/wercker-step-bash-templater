# General template processing using bash

This step uses script from [BASH-templater](https://github.com/johanhaleby/bash-templater) to parse template parameters using `{{VAR}}` by $VAR environment values.  
It supports **default** value for template parameters via `{{VAR=this_will_be_default_value}}`

## Example

```yml
deploy:
  steps:
  - axnux/bash-templater:
    template: example-input.yml
    output: example-output.yml   
    # your template parameter goes here
    parameters: |                            
      HEADER_LABEL=hello
      SUBTITLE_LABEL=world
```

## License

The step is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
