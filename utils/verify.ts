import { run } from "hardhat";
export const verify = async (contractAddress: string, args: unknown[]) => {
  console.log("Verifying contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (err: any) {
    if (err?.message.toLowerCase().includes("already verified")) {
      console.log("Already verified!");
    } else {
      console.log(err);
    }
  }
};
