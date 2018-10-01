# www.andrewbruce.net

This is a bare-bones website that serves as a playground for me to try new things in various languages.

The core website is generated from [Idris](https://www.idris-lang.org/) source code.

## Dependencies

- Idris. [Installation instructions](http://docs.idris-lang.org/en/latest/tutorial/starting.html)
- Make.

## Building

```
bundle install --binstubs # install wkhtmltopdf
make
```

## Viewing locally

```
bin/server
```

## License

Code is under [GPL v3](LICENSE).
