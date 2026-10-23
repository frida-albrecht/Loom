module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.956000e+01> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<1xf32>
    %2 = tosa.clamp %1 {max_val = 1.250000e+02 : f32, min_val = -1.600000e+01 : f32} : (tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.tanh %2 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.sigmoid %3 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.add %4, %1 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.abs %5 : (tensor<1xf32>) -> tensor<1xf32>
    %7 = tosa.reduce_max %6 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %8 = tosa.minimum %7, %6 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %9 = tosa.reduce_product %8 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

