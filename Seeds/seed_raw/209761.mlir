module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.580000e+01> : tensor<2x7x3xf32>}> : () -> tensor<2x7x3xf32>
    %1 = "tosa.const"() <{values = dense<1.256600e+02> : tensor<2x7x15xf32>}> : () -> tensor<2x7x15xf32>
    %2 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<2x7x3xf32>, tensor<2x7x15xf32>) -> tensor<2x7x18xf32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<2x7x18xf32>, tensor<2x7x18xf32>) -> tensor<4x7x18xf32>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<4x7x18xf32>) -> tensor<4x1x18xf32>
    %5 = tosa.floor %4 : (tensor<4x1x18xf32>) -> tensor<4x1x18xf32>
    %6 = tosa.tanh %5 : (tensor<4x1x18xf32>) -> tensor<4x1x18xf32>
    %7 = tosa.sigmoid %6 : (tensor<4x1x18xf32>) -> tensor<4x1x18xf32>
    %8 = tosa.reduce_product %7 {axis = 2 : i32} : (tensor<4x1x18xf32>) -> tensor<4x1x1xf32>
    %9 = tosa.log %8 : (tensor<4x1x1xf32>) -> tensor<4x1x1xf32>
    %cast = tensor.cast %9 : tensor<4x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

