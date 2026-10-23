module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.968600e+02> : tensor<1x383x128xf32>}> : () -> tensor<1x383x128xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %0 low[%c0, %c1, %c0] high[%c0, %c0, %c0] {
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      tensor.yield %cst : f32
    } : tensor<1x383x128xf32> to tensor<1x384x128xf32>
    %cast = tensor.cast %padded : tensor<1x384x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

