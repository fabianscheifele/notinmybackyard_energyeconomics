This folder includes the code and data to replicate the analysis of the paper "Not in My Backyard? The Local Impact of Wind and Solar Parks in Brazil" by Fabian Scheifele and David Popp (2025), published in Energy Economics

Please proceed with all the steps in the sequence outlined below to ensure that you can download all the publicly available data from the servers and construct all the intermediate datasets necessary to replicate the analysis using R.

Preparatory Steps:
1. Since this paper uses extremely large datasets such as the Brazilian Employment Registry (RAIS), you first need to create a Google Cloud Console account to access the data. For this, please visit: Google Cloud Console and create an account. Create several project IDs that you will need later to download the data within the R environment. While they are called "billing IDs" there is no cost involved in downloading these datasets. 

2. If you access the code files through GitHub, clone the repository to replicate the same folder structure (raw, intermediate, final and output). If you access this through a zip file, please extract the zip.

3. Ensure that you have at least 30 GB of available disk space to accommodate the files that will be downloaded in the process. Also, make sure that you have the latest versions of R and RStudio installed, and always run the first chunk that installs all the packages.

Data Preparation (will create data files in the subfolder "data"):

4. Open brazil_rejobs.Rproj to open the R project (important for relative file paths; always run the code with the project opened). Then run Markdown files 1-3 to create the renewable energy project dataset.

5. Open the file "4a- load administrative data," and put the project IDs created in Step 1 at all instances of set_billing_id("PUT ID HERE"). Make sure to use different billing IDs, as there is a maximum download size per ID. Then run 4a. Be aware this can take up to 1 hour since it will download various large datasets. When you run this code for the first time, R will prompt you to link your google cloud console account by entering email and password and make sure that check all 4 boxes (incl. the two optional ones) when it asks about acccess/ permissions. Otherwise the download process of the datasets through the R-package "basedosdados" might not work.  For more info see here: https://basedosdados.github.io/mais/api_reference_r/   

6. Run files 4b and then 4c. For 4c, do the same ID replacement exercise as outlined in Step 5 prior to running the code.

7. Run the following files in this order:

- 5-merge annual panel data (can take 20-30 minutes)
- 6 monthly RAIS panel (can take 20-30 minutes)
- 7 1-to-1 matching: Does the matching and stores matching weights
- 7b 1-to-1 matching spillover unit: Repeat matching among spillover units
- 8 merge matching weights
- 8b merge matching weights for the spillover analysis

Data Analysis (will create outputs in subfolder "outputs")
8. Run 10a for main results.

9. Run 10b for heterogeneity results.

10. Run 10c for geographic spillovers.

11. Run 10d and 10e for robustness tests.

12. Run twofeweights.do to execute the negative weights test of Chaisemartin & d'Haultfeuille (2020).

Troubleshooting
In case the code does not run through:

Please check first that you have all required packages installed. You can re-run the first chunk in the respective markdown to do that.
Also, check for potential interactions with other packages that you have installed that are not part of this analysis.
In case of any questions, please contact: fscheifele@worldbank.org
