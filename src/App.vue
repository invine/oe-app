<template>
  <div id="app">
    <the-header v-on:clearOrder="clearOrder" />
    <the-order :specs="getSpecs(version, catalogType)" :order="order" />
  </div>
</template>

<script>
import TheHeader from "./components/TheHeader.vue";
import TheOrder from "./components/TheOrder.vue";

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
      version: "3",
      catalogType: "ProductCatalog",
      order: orderStorage.fetch(),
    };
  },
  methods: {
    getSpecs: function (version, catalogType) {
      if (this.catalogSnapshot) {
        return this.catalogSnapshot
          .find((obj) => {
            return obj.majorVersion == version;
          })
          .entitySpecs.filter((obj) => obj.catalogType == catalogType);
      }
      return [];
    },
    clearOrder: function () {
      this.order.extParams = [];
      this.order.orderItems = [];
    },
  },
  watch: {
    order: {
      handler: function (order) {
        orderStorage.save(order);
      },
      deep: true,
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
ul {
  list-style: none;
}
</style>
