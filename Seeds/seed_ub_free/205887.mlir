module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-134> : tensor<5x8x10x2xi32>}> : () -> tensor<5x8x10x2xi32>
    %1 = "tosa.const"() <{values = dense<false> : tensor<9x9x8x4xi1>}> : () -> tensor<9x9x8x4xi1>
    %2 = tosa.argmax %0 {axis = 3 : i32} : (tensor<5x8x10x2xi32>) -> tensor<5x8x10xi32>
    %3 = tosa.reduce_product %2 {axis = 1 : i32} : (tensor<5x8x10xi32>) -> tensor<5x1x10xi32>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<5x1x10xi32>) -> tensor<5x1x10xi32>
    %5 = tosa.reduce_all %1 {axis = 2 : i32} : (tensor<9x9x8x4xi1>) -> tensor<9x9x1x4xi1>
    %6 = tosa.reduce_max %5 {axis = 1 : i32} : (tensor<9x9x1x4xi1>) -> tensor<9x1x1x4xi1>
    %7 = tosa.reduce_sum %6 {axis = 1 : i32} : (tensor<9x1x1x4xi1>) -> tensor<9x1x1x4xi1>
    %8 = tosa.argmax %7 {axis = 2 : i32} : (tensor<9x1x1x4xi1>) -> tensor<9x1x4xi32>
    %9 = tosa.reduce_max %4 {axis = 1 : i32} : (tensor<5x1x10xi32>) -> tensor<5x1x10xi32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<9x1x4xi32>}> : () -> tensor<9x1x4xi32>
    %s0 = tosa.maximum %8, %c1 : (tensor<9x1x4xi32>, tensor<9x1x4xi32>) -> tensor<9x1x4xi32>
    %10 = tosa.intdiv %8, %s0 : (tensor<9x1x4xi32>, tensor<9x1x4xi32>) -> tensor<9x1x4xi32>
    %cast = tensor.cast %9 : tensor<5x1x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<9x1x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}