module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.260000e+01> : tensor<10x9xf32>}> : () -> tensor<10x9xf32>
    %1 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 1>} : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<10x9xf32>) -> tensor<1x9xf32>
    %4 = tosa.concat %3, %3 {axis = 0 : i32} : (tensor<1x9xf32>, tensor<1x9xf32>) -> tensor<2x9xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = tosa.negate %4, %5, %6 : (tensor<2x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x9xf32>
    %cast = tensor.cast %7 : tensor<2x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

