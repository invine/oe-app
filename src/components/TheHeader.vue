<template>
  <div class="panel is-primary">
    <div class="panel-heading">
      <span class="title">Table Order Entry</span>
    </div>
    <div class="panel-block">
      <!-- <span class="label sub-title">Catalog Version</span> -->
      <div class="label">Catalog Version</div>
      <select
        class="input"
        v-bind:value="value"
        v-on:change="$emit('input', $event.target.value)"
      >
        <option v-for="v in versions" v-bind:key="v">
          {{ v }}
        </option>
      </select>
      <button class="button is-primary" v-on:click="$emit('reloadCatalog')">
        Reload Catalog
      </button>
      <button class="button is-danger" v-on:click="$emit('clearOrder')">
        Clear Order
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "TheHeader",
  props: {
    value: String,
    catalogSnapshot: Array,
  },
  computed: {
    versions: function () {
      return this.catalogSnapshot.map((el) => el.majorVersion);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>