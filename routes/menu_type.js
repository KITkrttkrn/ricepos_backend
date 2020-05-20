const Models = require("../models");
const Joi = require("joi");
const Boom = require("boom");

module.exports = (function () {
  return [
    {
      method: "GET",
      path: "/menu_type",
      config: {
        description: "Get all menu_type",
        notes: "retrieve menu_type",
        tags: ["api"],
        auth: "jwt",
        handler: async (req, h) => {
          const menu_type = await Models.Menu_type.findAll({
            attributes: ["mt_id", "mt_name"],
          });

          if (menu_type == null) {
            return Boom.notFound("Type of menu not found");
          }

          return h.response(menu_type);
        },
      },
    },
    {
      method: "GET",
      path: "/menu_type/{id}",
      config: {
        description: "Get menu_type by id",
        notes: "retrieve menu_type via id",
        tags: ["api"],
        auth: "jwt",
        validate: {
          params: {
            id: Joi.number().integer().min(1).required(),
          },
        },
        handler: async (req, h) => {
          const menu_type = await Models.Menu_type.findOne({
            attributes: ["mt_id", "mt_name"],
            where: {
              mt_id: req.params.id,
            },
          });

          if (menu_type == null) {
            return Boom.notFound(
              "Type of menu not found with id: " + req.params.id
            );
          }

          return h.response(menu_type);
        },
      },
    },
    {
      method: "POST",
      path: "/menu_type",
      config: {
        description: "Insert menu_type",
        notes: "Insert menu_type",
        tags: ["api"],
        auth: "jwt",
        validate: {
          payload: {
            name: Joi.string().required(),
          },
        },
        handler: async (req, h) => {
          const menu_type = await Models.Menu_type.create({
            mt_name: req.payload.name,
          });

          if (menu_type == null) {
            return Boom.badRequest("Cannot insert type of menu");
          }

          return h.response("inserted " + menu_type.mt_id);
        },
      },
    },
    {
      method: "DELETE",
      path: "/menu_type/{id}",
      config: {
        description: "Delete menu_type",
        notes: "Delete menu_type",
        tags: ["api"],
        auth: "jwt",
        validate: {
          params: {
            id: Joi.number().integer().required(),
          },
        },
        handler: async (req, h) => {
          const menu_type = await Models.Menu_type.findByPk(req.params.id);
          if (menu_type == null) {
            return Boom.badRequest("Cannot delete type of menu");
          }
          const index = await Models.Menu_type.destroy({
            where: {
              mt_id: req.params.id,
            },
          });

          return h.response(index);
        },
      },
    },
    {
      method: "PUT",
      path: "/menu_type",
      config: {
        description: "Delete menu_type",
        notes: "Delete menu_type",
        tags: ["api"],
        auth: "jwt",
        validate: {
          payload: {
            id: Joi.number().integer().required(),
            name: Joi.string().required(),
          },
        },
        handler: async (req, h) => {
          const menu_type = await Models.Menu_type.findByPk(req.payload.id);
          if (menu_type == null) {
            return Boom.badRequest("Cannot update type of menu");
          }
          const index = await Models.Menu_type.update(
            {
              mt_name: req.payload.name,
            },
            {
              where: {
                mt_id: req.payload.id,
              },
            }
          );
          return h.response(index);
        },
      },
    },
  ];
})();
