module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.050000e+00> : tensor<1x2x9xf32>}> : () -> tensor<1x2x9xf32>
    %1 = tosa.rsqrt %0 : (tensor<1x2x9xf32>) -> tensor<1x2x9xf32>
    %2 = tosa.abs %1 : (tensor<1x2x9xf32>) -> tensor<1x2x9xf32>
    %3 = tosa.sigmoid %2 : (tensor<1x2x9xf32>) -> tensor<1x2x9xf32>
    %4 = tosa.argmax %3 {axis = 2 : i32} : (tensor<1x2x9xf32>) -> tensor<1x2xi32>
    %5 = tosa.add %4, %4 : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %6 = tosa.add %5, %4 : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %cast = tensor.cast %6 : tensor<1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

