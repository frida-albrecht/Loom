module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1x10x8x9xi1>}> : () -> tensor<1x10x8x9xi1>
    %1 = "tosa.const"() <{values = dense<false> : tensor<1x10x1x9xi1>}> : () -> tensor<1x10x1x9xi1>
    %2 = tosa.logical_and %0, %1 : (tensor<1x10x8x9xi1>, tensor<1x10x1x9xi1>) -> tensor<1x10x8x9xi1>
    %3 = tosa.argmax %2 {axis = 2 : i32} : (tensor<1x10x8x9xi1>) -> tensor<1x10x9xi32>
    %4 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<1x10x9xi32>) -> tensor<1x1x9xi32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<1x1x9xi32>}> : () -> tensor<1x1x9xi32>
    %a1 = tosa.maximum %4, %c1 : (tensor<1x1x9xi32>, tensor<1x1x9xi32>) -> tensor<1x1x9xi32>
    %5 = tosa.intdiv %4, %a1 : (tensor<1x1x9xi32>, tensor<1x1x9xi32>) -> tensor<1x1x9xi32>
    %cast = tensor.cast %5 : tensor<1x1x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}