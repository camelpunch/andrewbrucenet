# www.andrewbruce.net

This is a bare-bones website that serves as a playground for me to try new things in various languages.

The core website is generated from [Idris](https://www.idris-lang.org/) source code.

## Dependencies

- Idris. [Installation instructions](http://docs.idris-lang.org/en/latest/tutorial/starting.html)
- GNU Make. Available in most distros and OSX (warning: OSX ships with the older 3.x.x version), but probably not Windows.

## Building

```
make
```

## Viewing locally (requires Python)

```
make clean serve
```

## Deploying

It is deployed to Cloud Foundry. `cf push` should be all you need to push it elsewhere.

## License

Code is under [GPL v3](LICENSE).
