# DBT boilerplate for converting iCarol to HSDS.

iCarol exports resource data as HSDS, but it leaves much to be desired. We have open sourced this project so you can manually transform their default formatted export and get a much higher quality transformation to HSDS.

## How to get started.

1. Clone or fork this repo.
2. Install DBT on your local or deployed environment(s). USE DBT CLI: https://docs.getdbt.com/dbt-cli/install/overview.
3. Don't forget to install adapter(s), for example `dbt-bigquery` or `dbt-postgres`.
4. Set up your profile to connect to your data base: https://docs.getdbt.com/dbt-cli/configure-your-profile

**Note:** If you are running DBT CLI you can optionally use `dbt init [project_name]` to get started. It will walk you through creating a profile. You may then copy over the models, and install the `dbt-utils` package: https://hub.getdbt.com/dbt-labs/dbt_utils/latest/.

Once DBT is installed and connected, tweak the project itself.
1. Update `./models/schema.yml` with your source tables: https://docs.getdbt.com/docs/building-a-dbt-project/using-sources
2. Tweak the models to fit your data.

## How this project is organized.
This organization is based loosely on DBTs recommended method: https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355

1. Define source tables "as is" in `models/src`. This allows them to be used in dependency graphs.
2. `models/stg` is where you start casting and renaming data. Staging may also be used for more advanced, intermediary transformations (see below).
3. Create your final models for HSDS tables in the root of the `models` directory.

**NOTE:** Best practices dictate that src should be no more than a strict model of source data. However, expediency in this case dictates adding tenant IDs and doing some low level casting in the source files in order to drastically DRY up code.

### How we chose our source tables for boilerplate.

Most of the data needed from iCarol comes from the default `resources` table. There are fields to handle all data related to the HSDS core tables, including location, service, phone, service area, taxonomy, and more. It's _possible_ that you will only need the main table.

However, we are providing boilerplate that gives an example of pulling service areas and taxonomies from separate default tables in iCarol and joining those, as this is a common use case as well.

Depending on your use case you will perhaps simplify that to just the `resource` tabe. If you do, you will need to update `schema.yml`, remove two of your `/models/src` files, and update references to those models in `models/stg`.

## Staging models.

The staging step for this boilerplate is critical. Most of the primary data for HSDS, including all four core tables, is in one table in iCarol. Therefore, the first staging step is to break those core tables out into their own models.

Additionally, some of the data (like phones and hours) exists in multiple core tables. In order to keep things DRY, I've put those in their own models at the staging level, and then joined them in where needed in the root HSDS tables.

## Disclaimer.

This was originally written for a specific client and is, in some places, opnionated based on how they happened to store their data in iCarol. You will likely have different assumptions about which fields to use, and how they should be used.

This project is provided "as is" with no guarantee that it will work and not bork your data. You are liable for all results. Use carefully, and don't test in production.

## Support, issues, suggestions, and questions.

Please open a Github issue with any feedback or questions you may have. We aren't offering free support, but we _are_ interested in engaging with the community and improving this boilerplate.

## Attribution

This project was originally created and contributed to Open Referral by C. Skyler Young at Connect 211 (https://connect211.com).