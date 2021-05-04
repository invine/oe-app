<template>
  <div id="app">
    <the-header
      :catalogSnapshot="catalogSnapshot"
      v-model="version"
      v-on:clearOrder="clearOrder"
      v-on:reloadCatalog="reloadCatalog"
      v-on:sendOrder="sendOrder"
    />
    <the-order v-if="version" :specs="specs" :order="order" />
  </div>
</template>

<script>
import getEnv from "@/utils/env";

import TheHeader from "./components/TheHeader.vue";
import TheOrder from "./components/TheOrder.vue";

var DEFAULT_CUSTOMER = {
  "@referredType": "Customer",
  role: "Customer",
  id: "default_toe_customer",
};

var CATALOG_STORAGE_KEY = "order-entry-catalog-vuejs-2.0";
var catalogSnapshotStorage = {
  fetch: function () {
    var catalogSnapshot = JSON.parse(
      localStorage.getItem(CATALOG_STORAGE_KEY) || "[]"
    );
    return catalogSnapshot;
  },
  save: function (catalogSnapshot) {
    localStorage.setItem(CATALOG_STORAGE_KEY, JSON.stringify(catalogSnapshot));
  },
};

var ORDER_STORAGE_KEY = "order-entry-order-vuejs-2.0";
var orderStorage = {
  fetch: function () {
    var order = JSON.parse(
      localStorage.getItem(ORDER_STORAGE_KEY) ||
        `{ "extParams": [], "orderItems": [] }`
    );
    return order;
  },
  save: function (order) {
    localStorage.setItem(ORDER_STORAGE_KEY, JSON.stringify(order));
  },
};

export default {
  name: "App",
  components: {
    TheHeader,
    TheOrder,
  },
  data() {
    return {
      catalogSnapshot: catalogSnapshotStorage.fetch(),
      version: localStorage.getItem("order-entry-version-vuejs-2.0"),
      catalogType: "ProductCatalog",
      order: orderStorage.fetch(),
      catalogUrl: getEnv("CATALOG_URL"),
      tmf622Url: getEnv("TMF622_URL"),
    };
  },
  computed: {
    specs: function () {
      if (this.catalogSnapshot) {
        return (
          (
            this.catalogSnapshot.find((obj) => {
              return obj.majorVersion == this.version;
            }) || []
          ).entitySpecs || []
        ).filter((obj) => obj.catalogType == this.catalogType);
      }
      return [];
    },
  },
  methods: {
    clearOrder: function () {
      this.order.extParams = [];
      this.order.orderItems = [];
    },
    reloadCatalog: function () {
      fetch(this.catalogUrl + "/api/v1/om-ordering-catalog/catalog/snapshot")
        .then((response) => response.json())
        .then((data) => (this.catalogSnapshot = data))
        .catch((error) => {
          alert("Error:", error);
        });
    },
    sendOrder: function () {
      if (!this.order.relatedParty || this.order.relatedParty.length == 0) {
        this.order.relatedParty = [DEFAULT_CUSTOMER];
      }
      fetch(this.tmf622Url + "/productOrderingManagement/v1/productOrder", {
        method: "POST",
        headers: {
          Authorization:
            "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJvR1FqUDJ0X2NBTWdXNW1KRGE5MmdWYkllY1ZLdGd2YVNwMHJQM0pSMU1RIn0.eyJleHAiOjE2MjAxNDI4MDQsImlhdCI6MTYyMDEyODQwNCwianRpIjoiMjk1OGU2NDctZWRjYy00ODFjLWExNDAtMDYyZGFlYzRhYTBiIiwiaXNzIjoiaHR0cDovL3B1YmxpYy1nYXRld2F5LW9tLW9tZWdhLms4cy1hcHBzMi5rOHMuc2RudGVzdC5uZXRjcmFja2VyLmNvbS9hdXRoL3JlYWxtcy9jbG91ZC1jb21tb24iLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiZjYyYTNlZmQtYjVhMy00YWM1LWEyMTctNTUyM2FmNmQ5NmMwIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiZnJvbnRlbmQiLCJzZXNzaW9uX3N0YXRlIjoiZWRkMjIxZjEtMzRlZi00NTMzLWI2NjEtZjc4MjY3YjYwOGVhIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIlJPTEVfY2xvdWQtb20tdWktcmVhZC1hbGwiLCJST0xFX2Nsb3VkLW9tLXVpLXdyaXRlLWFsbCIsIlJPTEVfQkNfQURNSU5JU1RSQVRPUiIsIlJPTEVfY2xvdWQtb20tcmVhZC1wcm9kdWN0LW9yZGVyIiwiUk9MRV9jbG91ZC1vbS1jYXRhbG9nLXdyaXRlLWFsbCIsIlJPTEVfY2xvdWQtb20tc3VibWl0LXNlcnZpY2Utb3JkZXIiLCJST0xFX1VUTV9TVVBFUlZJU09SIiwiUk9MRV9jbG91ZC1vbS1jYXRhbG9nLXJlYWQtYWxsIiwib2ZmbGluZV9hY2Nlc3MiLCJST0xFX2Nsb3VkLW9tLXJlYWQtc2VydmljZS1vcmRlciIsIlJPTEVfY2xvdWQtb20tdXBkYXRlLW9yZGVyIiwidW1hX2F1dGhvcml6YXRpb24iLCJST0xFX2Nsb3VkLW9tLXN1Ym1pdC1wcm9kdWN0LW9yZGVyIiwiUk9MRV9URU5BTlQtQURNSU4iXX0sInNjb3BlIjoiIn0.Bwoq3B5vXObBd9ghJIV-xW_oplEiI_qZrjLvA3hvMnhXhK1Olfk7loDTj20zNsCrCpwqb9VBQa14h1JehZAKsAufdcCXSn8iMmnDOeMPHxNi2otzsqoI_-nBJux_Ph-x-Lp5l6NTfXrbXZ0xOexaxx9W-2knrjQytic_FNQ9iObi3u_g0Vt-DuB9Pu1xfdUFXR-YjLuHU-9p-zUe2mtpUXz28BSrpEmru0POEemb1Fwv318k_b6mSHDjyHWQQKxuRZz4bJFUAdTKFY1lyN_GQ1CW46r1OXs3jFu4lu4Lx58zE-A8t4eey3SrbDKnsoY2wYt6_xo0Xr9mVyZHHJfCgQ",
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify(this.order),
      })
        .then((response) => response.json())
        .then((data) => {
          alert("Success:", data);
        })
        .catch((error) => {
          alert("Error:", error);
        });
    },
  },
  watch: {
    version: {
      handler: function (version) {
        localStorage.setItem("order-entry-version-vuejs-2.0", version);
        this.clearOrder();
      },
    },
    order: {
      handler: function (order) {
        orderStorage.save(order);
      },
      deep: true,
    },
    catalogSnapshot: {
      handler: function (catalogSnapshot) {
        catalogSnapshotStorage.save(catalogSnapshot);
        this.clearOrder();
      },
      deep: true,
    },
  },
};
</script>

<style>
#app {
  font-family: Roboto, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
ul {
  list-style: none;
}
</style>
