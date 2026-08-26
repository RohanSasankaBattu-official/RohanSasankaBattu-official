<!-- Custom hero banner — upload banner.png to THIS repo alongside the README -->
<div align="center">

<img src="./banner.png" alt="Rohan Sasanka Battu — Senior Data & Cloud Architect" width="100%" />

<br/>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=22&pause=1200&color=29B5E8&center=true&vCenter=true&width=820&lines=I+turn+legacy+data+chaos+into+governed+Snowflake+platforms.;100s+of+TB+migrated+%C2%B7+20-35%25+cloud+spend+cut.;Now+building+AI-native+data+products+with+Cortex." alt="tagline" />

<br/><br/>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/rohan-sasanka-542704215)
[![Email](https://img.shields.io/badge/Email-29B5E8?style=flat-square&logo=maildotru&logoColor=white)](mailto:rohansasanka3@gmail.com)
![Location](https://img.shields.io/badge/Bengaluru%20·%20Remote%2FGlobal-30363d?style=flat-square&logo=googlemaps&logoColor=white)
![Views](https://komarev.com/ghpvc/?username=RohanSasankaBattu-official&label=Profile+views&color=29B5E8&style=flat-square)

</div>

<br/>

## ⧉ The architecture of my career

> I don't just *use* the Medallion pattern — my whole journey **is** one.
> Raw sources on the left, refined through every role, into measurable impact.

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

<br/>

## ⌘ whoami — as a query

```sql
SELECT  role, focus, currently_shipping
FROM    architects
WHERE   name = 'Rohan Sasanka Battu'
  AND   experience_years >= 10
  AND   platforms @> ARRAY['Snowflake','AWS','Azure'];

-- ┌──────────────────────────┬────────────────────────────┬───────────────────────────────┐
-- │ role                     │ focus                      │ currently_shipping            │
-- ├──────────────────────────┼────────────────────────────┼───────────────────────────────┤
-- │ Senior Data & Cloud Arch │ Migrate · Govern · AI-enable│ Cortex + Semantic Views (AI)  │
-- └──────────────────────────┴────────────────────────────┴───────────────────────────────┘
```

<br/>

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

<br/>

## ▲ Impact, in numbers

<div align="center">

| `10+ yrs` | `100s TB` | `20–35%` | `15 engineers` | `9 PODs` |
|:--:|:--:|:--:|:--:|:--:|
| architecting | migrated to Snowflake | cloud cost cut | led & mentored | governed end-to-end |

</div>

<br/>

## ◱ Signals from the platform

<div align="center">

<img height="165em" src="https://github-readme-stats.vercel.app/api?username=RohanSasankaBattu-official&show_icons=true&count_private=true&hide_border=true&custom_title=Rohan%20·%20Build%20Stats&theme=react&title_color=29B5E8&icon_color=29B5E8" />
<img height="165em" src="https://github-readme-streak-stats.herokuapp.com/?user=RohanSasankaBattu-official&hide_border=true&theme=react&stroke=29B5E8&ring=29B5E8&fire=29B5E8&currStreakLabel=29B5E8" />

</div>

<br/>

<div align="center">

### ❄️ Building something data-heavy? Let's talk architecture.

[![Connect](https://img.shields.io/badge/Connect_on_LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rohan-sasanka-542704215)
[![Email](https://img.shields.io/badge/Start_a_conversation-29B5E8?style=for-the-badge&logo=maildotru&logoColor=white)](mailto:rohansasanka3@gmail.com)

</div>
