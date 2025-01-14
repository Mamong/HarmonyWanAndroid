import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import logger from './Logger';
import { toast } from './ToastUtils';

export function startBrowsableAbility(context: common.UIAbilityContext, url: string) {
  let want: Want = {
    action: 'ohos.want.action.viewData',
    entities: ['entity.system.browsable'],
    uri: url
  };
  context.startAbility(want)
    .then(() => {
      logger.info(`成功打开：${url} `)
    })
    .catch((e: BusinessError) => {
      toast("打开浏览器失败")
      logger.error(`code = ${e.code}, message = ${e.message}`)
    });
}