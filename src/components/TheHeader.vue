<template>
  <nav class="navbar sticky-top navbar-light bg-light">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Order Entry</span>
      <div class="row g-3 align-items-center">
              <!-- <div class="col-auto">
          <label class="col-form-label">Catalog</label>
        </div> -->
        <div class="col-auto">
          <select
            class="form-select"
            v-bind:value="value"
            v-on:change="$emit('input', $event.target.value)"
          >
            <option v-for="v in versions" v-bind:key="v">
              {{ v }}
            </option>
          </select>
        </div>
        <div class="col-auto">
          <button
            class="btn btn-outline-primary"
            v-on:click="$emit('reloadCatalog')"
          >
            <i class="bi bi-arrow-repeat"></i>
          </button>
        </div>
        <div class="col-auto">
          <button
            class="btn btn-outline-success"
            v-on:click="$emit('sendOrder')"
          >
            Send
          </button>
        </div>
        <div class="col-auto">
          <button
            class="btn btn-outline-danger"
            v-on:click="$emit('clearOrder')"
          >
            Clear
          </button>
        </div>
      </div>
      <!-- </form> -->
    </div>
  </nav>
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
</style>
