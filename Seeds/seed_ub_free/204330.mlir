module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.040000e+00> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.322100e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<12> : tensor<9xi32>}> : () -> tensor<9xi32>
    %3 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<9xi32>) -> tensor<1xi32>
    %5 = tosa.intdiv %4, %4 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.bitwise_and %5, %5 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %9 = tosa.negate %4, %7, %8 : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

