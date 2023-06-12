FROM grafana/grafana

COPY datasource-prometheus.yml ${GF_PATHS_PROVISIONING}/datasources/
COPY dashboard-provider.yml ${GF_PATHS_PROVISIONING}/dashboards/
COPY dashboard.json /var/lib/grafana/dashboards/