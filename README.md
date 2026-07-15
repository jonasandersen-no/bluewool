# Bluewool 🧶

A custom Minecraft modpack managed using [packwiz](https://packwiz.infra.link/).

---

## 🚀 Getting Started

### 1. Install Packwiz
To manage or build this modpack, you need to have Go installed. Run the following command to install the packwiz CLI:

```shell
go install github.com/packwiz/packwiz@latest

```

### 2. Import a CurseForge Modpack

If you are importing a fresh CurseForge export `.zip` to start or update the project:

```shell
packwiz curseforge import <path-to-zip>

```

---

## 🛠️ Developer Workflow

Use these commands in your terminal to keep the modpack updated and ready for release.

### Update All Mods

Automatically check and update every mod in the pack to its latest compatible version:

```shell
packwiz curseforge update --all

```

### Export for CurseForge

Export the project into a lightweight, CurseForge-compliant `.zip` file ready for upload:

```shell
packwiz curseforge export

```