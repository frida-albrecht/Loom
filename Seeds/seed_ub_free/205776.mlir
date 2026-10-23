module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<10x1x5x7xi1>}> : () -> tensor<10x1x5x7xi1>
    %1 = "tosa.const"() <{values = dense<-2.907000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = tosa.identity %0 : (tensor<10x1x5x7xi1>) -> tensor<10x1x5x7xi1>
    %3 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<10x1x5x7xi1>) -> tensor<1x1x5x7xi1>
    %4 = tosa.logical_or %3, %3 : (tensor<1x1x5x7xi1>, tensor<1x1x5x7xi1>) -> tensor<1x1x5x7xi1>
    %5 = tosa.argmax %4 {axis = 3 : i32} : (tensor<1x1x5x7xi1>) -> tensor<1x1x5xi32>
    %6 = tosa.tanh %1 : (tensor<4xf32>) -> tensor<4xf32>
    %7 = tosa.sub %6, %6 : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %8 = tosa.add %7, %7 : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %cast = tensor.cast %5 : tensor<1x1x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

