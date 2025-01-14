import { promptAction } from '@kit.ArkUI'
import logger from './Logger'
import { BusinessError } from '@kit.BasicServicesKit'

export function toast(ctx: UIContext, message: string | Resource, duration: number = 2_000) {
  try {
    ctx.getPromptAction().showToast({
      message: message,
      duration: duration
    })
  } catch (error) {
    let message = (error as BusinessError).message
    let code = (error as BusinessError).code
    console.error(`showToast args error code is ${code}, message is ${message}`);
  };
  logger.info(message.toString())
}

export function toastShort(ctx: UIContext, message: string | Resource) {
  toast(ctx, message, 1_500)
}

export function toastLong(ctx: UIContext, message: string | Resource) {
  toast(ctx, message, 5_000)
}

export function toastLongLong(ctx: UIContext, message: string | Resource) {
  toast(ctx, message, 10_000)
}