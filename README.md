# sheets_i18n

A flutter tool to synchronize i18n (internationalization) arb files with google sheets.

## Usage

### 1. Prerequisites with `intl_translation`

1. Having setup `intl_translation`
2. Having run the `intl_translation` commands to generate the arb files [github.com/dart-lang/i18n](https://github.com/dart-lang/i18n/tree/main/pkgs/intl_translation#extracting-and-using-translated-messages)

### 2. Install this package

`flutter pub add sheets_i18n`

### 3. Configure the pubspec.yaml

add this section:

```yaml
sheets_i18n:
  service_account_path: ./service_account.json
  sheet_id: 34tv34rv324rv23rv3r43r43red89f8hs89duzfs
```

### 4. Run the sync script

`flutter pub run sheets_i18n:update`

This will 2-way-sync all the changes:
- message keys that are not present in the Google Sheet will be added
- new translations will be pulled and written to the arb files

### 5. Run `intl_translation`'s arb to dart

Run the `intl_translation` commands to generate the dart code from the arb files [github.com/dart-lang/i18n](https://github.com/dart-lang/i18n/tree/main/pkgs/intl_translation#extracting-and-using-translated-messages)
