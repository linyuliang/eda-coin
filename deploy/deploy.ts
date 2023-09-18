import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { verify } from "../utils/verify";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  const params=["0x273C56aB79156ae783c6D3d4463d08e519CD92A7","EDA Token","EDA"];
  const edaCoin = await deploy("EdaToken", {
    from: deployer,
    args: params,
    log: true,
  });
  console.log(`eda coin contract: `, edaCoin.address);

  console.log("Waiting for block confirmations...");
  await verify(edaCoin.address, params);
};
export default func;
func.id = "deploy_eda_token"; // id required to prevent reexecution
func.tags = ["EdaToken"];
