### 🌐 [English](README.md) | [Deutsch](README.de.md) | [Svenska](README.sv.md)

# Olist Brasiliansk E handels Data Warehouse Projekt

Det här är ett data engineering projekt som visar en komplett data warehouse lösning där ett data warehouse byggs för att hjälpa dataanalytiker att hitta användbara insikter i data. Datasetet som används i projektet kommer från den brasilianska e handelsplattformen "Olist".

---

## Innehållsförteckning

1. [Projektkrav](#projektkrav)
2. [Dataarkitektur](#dataarkitektur)
3. [Bronze lagret](#bronze-lagret)
4. [Silver lagret](#silver-lagret)
5. [Gold lagret](#gold-lagret)
6. [Repositorystruktur](#repositorystruktur)
7. [Klona repositoryt](#klona-repositoryt)
8. [Licens och erkännanden](#licens-och-erkännanden)
9. [Om mig](#om-mig)

---

## Projektkrav

### Bygga Data Warehouse

#### Mål

Utveckla ett modernt data warehouse med SQL Server för att konsolidera försäljnings och orderdata och möjliggöra analytisk rapportering samt bättre beslutsfattande.

#### Specifikationer

* **Datakällor:** Importera CSV filer från Kaggle datasetet [Brazilian E Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data).
* **Datakvalitet:** Rensa data och åtgärda datakvalitetsproblem innan analys.
* **Integration:** Skapa en enda användarvänlig datamodell optimerad för analytiska frågor.
* **Omfattning:** Fokusera endast på den senaste datamängden. Historisering krävs inte.
* **Dokumentation:** Tillhandahåll tydlig dokumentation av datamodellen för både verksamheten och analysteam.

#### Namngivningskonventioner

Specifika namngivningskonventioner har följts för att standardisera fil och tabellnamn. Mer information finns [här](docs/naming_conventions.md).

---

## Dataarkitektur

Projektets dataarkitektur följer Medallion Architecture med lagren **Bronze**, **Silver** och **Gold**.

![Data Architecture](docs/Data_Architecture.png)

## Bronze lagret

Bronze lagret lagrar rådata exakt som den tas emot från källfilerna.

Inga transformationer utförs under inläsningen.

Data laddas direkt från CSV filer till SQL Server med hjälp av kommandot `BULK INSERT` via den lagrade proceduren `bronze.load_bronze`.

Bronze skript finns i

```
scripts/bronze
```

Dataflöde

![Data Flow Diagram](docs/Data_Flow_Diagram.png)

## Silver lagret

Silver lagret fokuserar på datarensning, standardisering och normalisering.

Viktiga transformationer omfattar

* Borttagning av redundanta kundidentifierare
* Korrigering av felaktiga kolumnnamn
* Ersättning av NULL värden med meningsfulla standardvärden
* Standardisering av betalningstyper
* Sammanfogning av duplicerade geolokaliseringsposter
* Borttagning av dubbla kundposter
* Skapande av en post per unik kund

Omfattande valideringsfrågor skapades också för att kontrollera

* Duplicerade nycklar
* Saknade värden
* Ogiltiga datum
* Datakonsistens

Silver skript

```
scripts/silver
```

Kvalitetskontroller

```
tests/data_quality_check_silver.sql
```

Dataintegrationsmodell

![Data Integration Model](docs/Data_Integration_Model.png)

## Gold lagret

Gold lagret innehåller affärsanpassade analytiska modeller som följer ett Galaxy Schema.

Data warehouset består av tre dimensionstabeller

* Kunder
* Produkter
* Säljare

och tre faktatabeller

* Försäljningsrader
* Orderbetalningar
* Orderrecensioner

Dessa vyer är optimerade för analytisk rapportering samtidigt som referensintegriteten bevaras i hela data warehouset.

Gold skript

```
scripts/gold
```

Kvalitetskontroller

```
tests/data_quality_check_gold.sql
```

Datakatalog

```
docs/data_catalog.md
```

Galaxy Schema

![Data Model](docs/Data_Model.png)

---

## Repositorystruktur

```text
Olist-Brazilian-E-Commerce-Data-Warehouse-Project/
│
├── datasets/                           # Rådata som används i projektet
│
├── docs/                               # Projektdokumentation och arkitekturbeskrivningar
│   ├── Data_Architecture               # Draw.io fil som visar projektets arkitektur
│   ├── data_catalog.md                 # Datakatalog med fältbeskrivningar och metadata
│   ├── Data_Flow_Diagram               # Draw.io fil för dataflödesdiagrammet
│   ├── Data_Model                      # Draw.io fil för datamodellen (Galaxy Schema)
│   ├── naming-conventions.md           # Riktlinjer för namngivning av tabeller, kolumner och filer
│
├── scripts/                            # SQL skript för ETL och transformationer
│   ├── bronze/                         # Skript för inläsning av rådata
│   ├── silver/                         # Skript för datarensning och transformation
│   ├── gold/                           # Skript för analytiska modeller
│
├── tests/                              # Testskript och kvalitetskontroller
│
├── README.md                           # Projektöversikt och instruktioner
├── README.de.md                        # Tysk översättning
├── README.sv.md                        # Svensk översättning
├── LICENSE                             # Information om projektets licens
```

## Klona repositoryt

```bash
git clone https://github.com/Molo-M/Olist-Brazilian-E-Commerce-Data-Warehouse-Project.git
```

---

## Licens och erkännanden

Detta projekt är licensierat under [MIT License](LICENSE).

## Om mig

Hej! Jag heter **Molo Munyansanga**. Jag är IT specialist och en passionerad dataentusiast som tycker om att arbeta med data.

Låt oss hålla kontakten! Du är varmt välkommen att connecta med mig på

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/molomunyansanga/)
