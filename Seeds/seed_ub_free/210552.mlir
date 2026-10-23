module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.410000e+00> : tensor<3x7x5xf32>}> : () -> tensor<3x7x5xf32>
    %1 = tosa.rsqrt %0 : (tensor<3x7x5xf32>) -> tensor<3x7x5xf32>
    %2 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<3x7x5xf32>) -> tensor<1x7x5xf32>
    %3 = tosa.sigmoid %2 : (tensor<1x7x5xf32>) -> tensor<1x7x5xf32>
    %cast = tensor.cast %3 : tensor<1x7x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

