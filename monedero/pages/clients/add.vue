<template>
  <a-row>
    <a-col :span="24">
      <a-breadcrumb>
        <a-breadcrumb-item>
          <a href="/">
            <a-icon type="home" />
          </a>
        </a-breadcrumb-item>
        <a-breadcrumb-item>
          <NuxtLink to="/clients"> Clientes </NuxtLink>
        </a-breadcrumb-item>
        <a-breadcrumb-item>Form. Cliente</a-breadcrumb-item>
      </a-breadcrumb>

      <a-page-header
        style="border-bottom: 1px solid rgb(235, 237, 240); margin-bottom: 16px"
        title="Registro de Cliente"
      />

      <a-form :form="form" @submit="handleSubmit">
        <a-row :gutter="[16,16]">
          <a-col :span="6">
            <a-form-item label="Nombres">
              <a-input
                v-decorator="[
                  'name',
                  {
                    rules: [messageRequired, messageRequiredMin],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          <a-col :span="6">
            <a-form-item label="Documento">
              <a-input
                v-decorator="[
                  'document',
                  {
                    rules: [messageRequired, messageRequiredMin],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          <a-col :span="6">
            <a-form-item label="Correo Electrónico">
              <a-input
                v-decorator="[
                  'email',
                  {
                    rules: [messageRequired, messageRequiredEmail],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          <a-col :span="6">
            <a-form-item label="Teléfono">
              <a-input
                v-decorator="[
                  'phone',
                  {
                    rules: [messageRequired, messageRequiredMin],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
         
        </a-row>
        <a-row style="text-align: center;">
            <a-button type="primary" html-type="submit"> Guardar </a-button>
        </a-row>
      </a-form>
    </a-col>
  </a-row>
</template>

<script>

export default {
  data() {
    return {
      newCompany: {}, 
      messageRequired: { 
        required: true, 
        message: 'Campo requerido!',
      },
      messageRequiredMin: { 
        min: 3,
        message: 'Se requiere mas de 3 carácteres!!',
      },
      messageRequiredEmail: {
        type: 'email',
        message: '¡Por favor, introduzca su correo electrónico!',
      },
      form: this.$form.createForm(this, { name: 'coordinated' }),
    }
  },
  methods: {
    openNotification(resp, type) {
      this.$notification[type]({
        message: type === "success" ? "¡ÉXITO!" : type === "error" ? "¡ALERTA!" : "¡ATENCIÓN!" ,
        description: type === "error" ? "Hubo un error al comunicar con el servidor." : resp ,
        placement: 'bottomRight',
      });
    },
    async handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) { this.newCompany = values; } 
        else { this.newCompany = false }
      });

      if (this.newCompany) { 
        const response  =  await this.$axios.$post('http://local-epayco/restuser/create', this.newCompany)
        try {
          if (response.code === 200) {
            this.openNotification(response.message, "success");
            this.$router.back();
          } else { 
            this.openNotification(response.message, "warning");
          }
        } catch (error) {
          this.openNotification(error, "error");
        }
      }
    },
  },
}
</script>
