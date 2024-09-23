# sheets_i18n

A flutter tool to synchronize i18n (internationalization) arb files with google sheets.

## Usage

### 1. Prepare a Google Sheet Document

<img width="637" alt="Screenshot 2024-09-23 at 09 45 39" src="https://github.com/user-attachments/assets/088de4fe-2dcf-466f-a507-03abfcd85e19">

You can get the sample here: [docs.google.com](https://docs.google.com/spreadsheets/d/1FY5zf1ngPyFsnv5F15BafzVA7UYi0kP3cZ4LE3XhZzY/edit?usp=sharing)

It should look like this:
- the first column is the message key (used to lookup the translation in the app).
- the columns after that are the language codes.
- the rows are for each specific translated word/sentence.

### 2. Configure a service account

1. Create a new service account in the Google Cloud Console
2. Turn on the Google Sheets API
3. Copy the service account's email address
4. Share the google sheet with the service account and give it edit privileges
    <img width="494" alt="Screenshot 2024-09-23 at 09 49 49" src="https://github.com/user-attachments/assets/33223e19-5da5-482e-be22-abee7d021ff4">
5. Download the service account JSON (it's local path will later be added to the pubspec configuration)

### 3. Prerequisites with `intl_translation`

1. Having setup `intl_translation`
2. Having run the `intl_translation` commands to generate the arb files [github.com/dart-lang/i18n](https://github.com/dart-lang/i18n/tree/main/pkgs/intl_translation#extracting-and-using-translated-messages)

### 4. Install this package

`flutter pub add sheets_i18n`

### 5. Configure the pubspec.yaml

add this section:

```yaml
sheets_i18n:
  service_account_path: ./service_account.json
  sheet_id: 34tv34rv324rv23rv3r43r43red89f8hs89duzfs
```

### 6. Run the sync script

`flutter pub run sheets_i18n:update`

This will 2-way-sync all the changes:
- message keys that are not present in the Google Sheet will be added
- new translations will be pulled and written to the arb files

### 7. Run `intl_translation`'s arb to dart

Run the `intl_translation` commands to generate the dart code from the arb files [github.com/dart-lang/i18n](https://github.com/dart-lang/i18n/tree/main/pkgs/intl_translation#extracting-and-using-translated-messages)
