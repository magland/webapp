import ccm_widgets as cw
cw.init_electron()

# View the clustering widget -- pointing to the server where we download the datasets
X = cw.Clustering(
    kachery_config=dict(
        fr='default_readonly'
    )
)
X.host(port=8080)