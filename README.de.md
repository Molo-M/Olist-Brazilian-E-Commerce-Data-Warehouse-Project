### 🌐 [English](README.md) | [Deutsch](README.de.md) | [Svenska](README.sv.md)

# Olist Data Warehouse Projekt für den brasilianischen E Commerce

Dieses Data Engineering Projekt demonstriert eine umfassende Data Warehousing Lösung, bei der ein Data Warehouse entwickelt wird, das Datenanalysten dabei unterstützt, wertvolle Erkenntnisse aus Daten zu gewinnen. Die verwendeten Daten stammen vom brasilianischen E Commerce Unternehmen „Olist“.

---

## Inhaltsverzeichnis

1. [Projektanforderungen](#projektanforderungen)
2. [Datenarchitektur](#datenarchitektur)
3. [Bronze Schicht](#bronze-schicht)
4. [Silver Schicht](#silver-schicht)
5. [Gold Schicht](#gold-schicht)
6. [Repository Struktur](#repository-struktur)
7. [Repository klonen](#repository-klonen)
8. [Lizenz und Danksagungen](#lizenz-und-danksagungen)
9. [Über mich](#über-mich)

---

## Projektanforderungen

### Aufbau des Data Warehouses (Data Engineering)

#### Ziel

Entwicklung eines modernen Data Warehouses mit SQL Server zur Konsolidierung von Verkaufs und Bestelldaten, um analytische Auswertungen und fundierte Geschäftsentscheidungen zu ermöglichen.

#### Anforderungen

* **Datenquellen:** Import der CSV Dateien aus dem [Brazilian E Commerce Public Dataset von Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data) auf Kaggle.
* **Datenqualität:** Bereinigung und Behebung von Datenqualitätsproblemen vor der Analyse.
* **Integration:** Erstellung eines einheitlichen und benutzerfreundlichen Datenmodells für analytische Abfragen.
* **Umfang:** Es wird ausschließlich der aktuellste Datensatz verwendet. Eine Historisierung der Daten ist nicht erforderlich.
* **Dokumentation:** Erstellung einer klaren Dokumentation des Datenmodells für Fachbereiche und Analytics Teams.

#### Namenskonventionen

Für Tabellen und Dateien wurden einheitliche Namenskonventionen verwendet. Weitere Informationen finden Sie [hier](docs/naming_conventions.md).

---

## Datenarchitektur

Die Datenarchitektur dieses Projekts folgt der Medallion Architektur mit den Schichten **Bronze**, **Silver** und **Gold**.

![Data Architecture](docs/Data_Architecture.png)

## Bronze Schicht

Die Bronze Schicht speichert die Rohdaten unverändert so, wie sie aus den Quelldateien übernommen werden.

Während des Imports werden keinerlei Transformationen durchgeführt.

Die Daten werden direkt aus den CSV Dateien mithilfe des `BULK INSERT` Befehls und der Stored Procedure `bronze.load_bronze` in SQL Server geladen.

Die SQL Skripte der Bronze Schicht befinden sich unter

```
scripts/bronze
```

Datenfluss

![Data Flow Diagram](docs/Data_Flow_Diagram.png)

## Silver Schicht

Die Silver Schicht konzentriert sich auf die Bereinigung, Standardisierung und Normalisierung der Daten.

Zu den wichtigsten Transformationen gehören

* Entfernen redundanter Kundenkennungen
* Korrigieren fehlerhafter Spaltennamen
* Ersetzen von NULL Werten durch sinnvolle Standardwerte
* Vereinheitlichen der Zahlungsarten
* Zusammenfassen doppelter Geolokationsdaten
* Entfernen doppelter Kundendatensätze
* Erstellen genau eines Datensatzes pro eindeutigem Kunden

Zusätzlich wurden umfangreiche Prüfungen implementiert, um Folgendes zu validieren

* Doppelte Schlüssel
* Fehlende Werte
* Ungültige Datumsangaben
* Datenkonsistenz

Silver Skripte

```
scripts/silver
```

Qualitätsprüfungen

```
tests/data_quality_check_silver.sql
```

Datenintegrationsmodell

![Data Integration Model](docs/Data_Integration_Model.png)

## Gold Schicht

Die Gold Schicht enthält analysefertige Datenmodelle, die einem Galaxy Schema folgen.

Das Data Warehouse besteht aus drei Dimensionstabellen

* Kunden
* Produkte
* Verkäufer

sowie drei Faktentabellen

* Verkaufspositionen
* Bestellzahlungen
* Bestellbewertungen

Diese Views sind für analytische Auswertungen optimiert und gewährleisten gleichzeitig die referenzielle Integrität innerhalb des Data Warehouses.

Gold Skripte

```
scripts/gold
```

Qualitätsprüfungen

```
tests/data_quality_check_gold.sql
```

Datenkatalog

```
docs/data_catalog.md
```

Galaxy Schema

![Data Model](docs/Data_Model.png)

---

## Repository Struktur

```
Olist-Brazilian-E-Commerce-Data-Warehouse-Project/
│
├── datasets/                           # Rohdatensätze des Projekts
│
├── docs/                               # Projektdokumentation und Architektur
│   ├── Data_Architecture               # Draw.io Datei der Datenarchitektur
│   ├── data_catalog.md                 # Datenkatalog mit Feldbeschreibungen und Metadaten
│   ├── Data_Flow_Diagram               # Draw.io Datei des Datenflusses
│   ├── Data_Model                      # Draw.io Datei des Galaxy Schemas
│   ├── naming_conventions.md           # Namenskonventionen für Tabellen, Spalten und Dateien
│
├── scripts/                            # SQL Skripte für ETL und Transformationen
│   ├── bronze/                         # Laden der Rohdaten
│   ├── silver/                         # Datenbereinigung und Transformation
│   ├── gold/                           # Erstellung der analytischen Modelle
│
├── tests/                              # Testskripte und Qualitätsprüfungen
│
├── README.md                           # Projektübersicht und Dokumentation
├── README.de.md                        # Deutsch Übersetzung
├── README.sv.md                        # Schwedisch Übersetzung
├── LICENSE                             # Lizenzinformationen
```

## Repository klonen

```bash
git clone https://github.com/Molo-M/Olist-Brazilian-E-Commerce-Data-Warehouse-Project.git
```

---

## Lizenz und Danksagungen

Dieses Projekt steht unter der [MIT Lizenz](LICENSE).

## Über mich

Hallo! Ich bin **Molo Munyansanga**. Ich bin IT Absolvent und begeistere mich für Data Engineering, Datenanalyse und alles rund um Daten.

Lass uns gerne in Kontakt bleiben. Du findest mich auf LinkedIn.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/molomunyansanga/)
