<!-- ══════════════════════════════════════════════════════════════════════════
     Rohan Sasanka Battu · Profile README (robust edition)
     Upload BOTH banner.svg AND this README to the profile repo.
     The banner animates on GitHub; the two mermaid blocks render as diagrams.
     ══════════════════════════════════════════════════════════════════════════ -->

<div align="center">

<img src="./banner.svg" alt="Rohan Sasanka Battu — Senior Data & Cloud Architect" width="100%" />

<br/>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=21&pause=1100&color=29B5E8&center=true&vCenter=true&width=860&lines=I+turn+legacy+data+chaos+into+governed+Snowflake+platforms.;100s+of+TB+migrated++%C2%B7++20-35%25+cloud+spend+cut++%C2%B7++9+PODs+governed.;Now+shipping+AI-native+data+products+with+Snowflake+Cortex." alt="tagline" />

<br/><br/>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/rohan-sasanka-542704215)
[![Email](https://img.shields.io/badge/Email-29B5E8?style=flat-square&logo=maildotru&logoColor=white)](mailto:rohansasanka3@gmail.com)
![Location](https://img.shields.io/badge/Bengaluru%20·%20Remote%2FGlobal-30363d?style=flat-square&logo=googlemaps&logoColor=white)
![Focus](https://img.shields.io/badge/Focus-Data%20%26%20Cloud%20Architecture-1d6fb8?style=flat-square)
![Views](https://komarev.com/ghpvc/?username=RohanSasankaBattu-official&label=Profile+views&color=29B5E8&style=flat-square)

</div>

---

<table>
<tr>
<td width="50%" valign="top">

### ⚡ Currently

- 🏗️ Architecting **SQL Server → Snowflake** migrations for US healthcare (Ventra · Sound Physicians)
- 🤖 Building the org's **first AI-powered data platform** — Cortex + Semantic Views
- 🧩 Scaling a **multi-agent delivery framework** for peer-review & data-quality
- 🎯 Certifying: **SnowPro Advanced Architect** · **AWS SA**

</td>
<td width="50%" valign="top">

### 🧠 How I think about data

- **Govern before you scale** — RBAC & cost visibility from day one
- **Medallion, always** — Bronze → Silver → Gold, lineage end-to-end
- **Everything as code** — Terraform, DBT, CI/CD; no click-ops
- **Make it self-serve** — curated data products, not ticket queues

</td>
</tr>
</table>

---

## ⧉ My career, drawn as the architecture I build

> I don't just *use* the Medallion pattern — my whole journey **is** one:
> raw sources on the left, refined through every role, into measurable impact.

```mermaid
flowchart LR
    classDef bronze fill:#2a1e0f,stroke:#b08d57,color:#e8c9a0,stroke-width:2px;
    classDef silver fill:#1c2026,stroke:#c0c5ce,color:#e6e9ee,stroke-width:2px;
    classDef gold   fill:#2a2410,stroke:#d6b24a,color:#f2e2a8,stroke-width:2px;
    classDef serve  fill:#08303f,stroke:#29b5e8,color:#bdecff,stroke-width:2px;
    classDef impact fill:#0c2a1a,stroke:#3fbf6f,color:#bff2d0,stroke-width:2px;

    subgraph SRC[" 🗄️ RAW SOURCES "]
        direction TB
        S1[SQL Server]:::bronze
        S2[Oracle / On-Prem DW]:::bronze
        S3[Multi-vendor feeds]:::bronze
    end
    subgraph ING[" 🥉 INGEST · Wipro → Cognizant "]
        I1[Talend · Attunity CDC<br/>Fivetran · ADF]:::bronze
    end
    subgraph TRN[" 🥈 TRANSFORM · ZoomInfo → Globant "]
        T1[Medallion · DBT<br/>Terraform · CI/CD]:::silver
    end
    subgraph GOV[" 🥇 GOVERN · Convera · 9 PODs "]
        G1[RBAC · Cost Governance<br/>Warehouse Tuning]:::gold
    end
    subgraph SRV[" ❄️ SERVE · CitiusTech "]
        V1[Semantic Views<br/>Cortex AI · Data Products]:::serve
    end
    subgraph IMP[" 📈 IMPACT "]
        M1[100s TB migrated]:::impact
        M2[20–35% cost ↓]:::impact
        M3[First AI data platform]:::impact
    end

    S1 & S2 & S3 --> I1 --> T1 --> G1 --> V1 --> M1 & M2 & M3
```

---

## ⎇ …and as a commit history

```mermaid
gitGraph
   commit id: "2016 · Wipro"
   commit id: "Azure + Snowflake on Xerox"
   branch cognizant
   checkout cognizant
   commit id: "2020 · Architect track"
   commit id: "Generic ADF framework"
   checkout main
   merge cognizant
   commit id: "2022 · ZoomInfo · IaC"
   branch convera
   checkout convera
   commit id: "9 PODs governed"
   commit id: "20–35% cost ↓" type: HIGHLIGHT
   checkout main
   merge convera tag: "2.5 yrs · Convera"
   commit id: "2025 · CitiusTech"
   commit id: "Cortex + Semantic Views" tag: "v-AI-platform"
```

---

## ⌘ `whoami` — as a query

```sql
SELECT  role, focus, currently_shipping
FROM    architects
WHERE   name = 'Rohan Sasanka Battu'
  AND   experience_years >= 10
  AND   platforms @> ARRAY['Snowflake','AWS','Azure'];

-- ┌───────────────────────────┬──────────────────────────────┬──────────────────────────────┐
-- │ role                      │ focus                        │ currently_shipping           │
-- ├───────────────────────────┼──────────────────────────────┼──────────────────────────────┤
-- │ Senior Data & Cloud Arch. │ Migrate · Govern · AI-enable │ Cortex + Semantic Views (AI) │
-- └───────────────────────────┴──────────────────────────────┴──────────────────────────────┘
```

---

## ◈ The stack I build with

<div align="center">

**Platforms**  
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white) ![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=FF9900) ![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)

**Engineer & Model**  
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white) ![SQL](https://img.shields.io/badge/Advanced_SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white) ![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white)

**Move & Automate**  
![Talend](https://img.shields.io/badge/Talend-FF6D70?style=for-the-badge&logo=talend&logoColor=white) ![Fivetran](https://img.shields.io/badge/Fivetran-0073E6?style=for-the-badge&logo=fivetran&logoColor=white) ![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white) ![Azure DevOps](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azuredevops&logoColor=white)

**AI-Native**  
![Cortex](https://img.shields.io/badge/Snowflake_Cortex-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white) ![Copilot](https://img.shields.io/badge/GitHub_Copilot-000000?style=for-the-badge&logo=githubcopilot&logoColor=white)

</div>

---

## ▲ Impact, in numbers

<div align="center">

| `10+ yrs` | `100s TB` | `20–35%` | `15 engineers` | `9 PODs` | `6 yrs` |
|:--:|:--:|:--:|:--:|:--:|:--:|
| architecting | migrated to Snowflake | cloud cost cut | led & mentored | governed E2E | flagship client (Xerox) |

</div>

---

## ◱ Signals from the platform

<div align="center">

<img height="165em" src="https://github-readme-stats.vercel.app/api?username=RohanSasankaBattu-official&show_icons=true&count_private=true&hide_border=true&custom_title=Rohan%20·%20Build%20Stats&theme=react&title_color=29B5E8&icon_color=29B5E8" />
<img height="165em" src="https://github-readme-streak-stats.herokuapp.com/?user=RohanSasankaBattu-official&hide_border=true&theme=react&stroke=29B5E8&ring=29B5E8&fire=29B5E8&currStreakLabel=29B5E8" />

<img src="https://github-profile-trophy.vercel.app/?username=RohanSasankaBattu-official&theme=nord&no-frame=true&no-bg=true&margin-w=6&column=7" alt="trophies" />

<img width="98%" src="https://github-readme-activity-graph.vercel.app/graph?username=RohanSasankaBattu-official&bg_color=0d1117&color=29b5e8&line=29b5e8&point=ffffff&area=true&hide_border=true&custom_title=Contribution%20Activity" alt="activity graph" />

</div>

---

<div align="center">

### ❄️ Building something data-heavy? Let's architect it right.

I advise on Snowflake architecture, enterprise cloud migration, cost governance, and AI-driven data engineering.

[![Connect](https://img.shields.io/badge/Connect_on_LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rohan-sasanka-542704215)
[![Email](https://img.shields.io/badge/Start_a_conversation-29B5E8?style=for-the-badge&logo=maildotru&logoColor=white)](mailto:rohansasanka3@gmail.com)

<sub>Designed as a data platform, because that's what I do. ❄️</sub>

</div>
