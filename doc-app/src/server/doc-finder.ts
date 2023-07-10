import { env } from "~/env.mjs";
import fs from "fs";

export type DocProject = {
  name: string;
  href: string;
}

export const findDoc = () => {
  const base: string = "./public";
  let projects: string [] = fs.readdirSync(base);
  let suffix: string = "html/index.html";
  projects = projects.filter((proj) => {
    console.log(`${proj}`);
    try {
      return fs.statSync(`${base}/${proj}/${suffix}`).isFile();
    } catch(err) {
      console.log(`${err}`);
      return false;
    }
  })
  let map: DocProject [] = projects.map( (proj) => {
    return {
      name: `${proj}`,
      href: `${proj}/${suffix}`,
    }
  });
  return map;
}

