# Braai Boss

Offline-first Flutter app (South Africa braai vibes) with hardcoded data,
Material 3, and scaffolding for AdMob + In‑App Purchases.

## What’s included

- `lib/screens/`: Home, Recipes, Timer, Checklist
- `lib/models/`: `BraaiRecipe`
- `lib/data/`: `fakeBraaiRecipes` (offline-first)
- `lib/widgets/`: `BraaiCard`, `CountdownTimer`
- `lib/services/`: `AdService` (safe init + error captured)

## Run it locally

This folder contains the app code, but **does not include the platform
folders** (`android/`, `ios/`, etc.). To generate them:

```bash
cd braai_boss

# Backup the current lib/ (Flutter create can overwrite it)
mv lib lib_custom

flutter create .

# Restore the Braai Boss lib/
rm -rf lib
mv lib_custom lib

flutter pub get
flutter run
```

## Next steps

- Add a real AdMob banner widget (using test ad unit IDs first)
- Add an `IapService` wrapper (query products, handle restores)
- Persist checklist + timer presets using `shared_preferences`

