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
import TheHeader from "./components/TheHeader.vue";
import TheOrder from "./components/TheOrder.vue";

var CATALOG_URL = process.env.CATALOG_URL ? process.env.CATALOG_URL : "http://localhost:18084";
var TMF622_URL = process.env.TMF622_URL ? process.env.TMF622_URL : "http://localhost:18081";

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
      fetch(CATALOG_URL + "/api/v1/om-ordering-catalog/catalog/snapshot")
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
      fetch(TMF622_URL + "/productOrderingManagement/v1/productOrder", {
        method: "POST",
        headers: {
         'Accept': 'application/json',
         'Content-Type': 'application/json'
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
