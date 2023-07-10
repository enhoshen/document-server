import { z } from "zod";
import {
  createTRPCRouter,
  publicProcedure,
  protectedProcedure,
} from "~/server/api/trpc";
import { DocProject, findDoc } from "~/server/doc-finder";

export const docRouter = createTRPCRouter({
  hello: publicProcedure
    .input(z.object({ text: z.string() }))
    .query(({ input }) => {
      return {
        greeting: `Hello ${input.text}`,
      };
    }),

  getAll: publicProcedure.query(({ ctx }) => {
    return ctx.prisma.example.findMany();
  }),

  getSecretMessage: protectedProcedure.query(() => {
    return "you can now see this secret message!";
  }),

  getDocs: publicProcedure
    .query( () => {
      let projects: DocProject [] = findDoc()
      console.log(`tRPC: ${JSON.stringify(projects)}`);
      return {
        projects: projects,
      }
    }),
});
