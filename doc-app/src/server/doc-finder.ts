import { env } from "~/env.mjs";
import fs from "fs";

export const findDoc = () => {
  const base: string = env.DOC_BASE;
  let paths: string [] = fs.readdirSync(base);
  return paths;
}
