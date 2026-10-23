module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<7x6x4x5xi8>}> : () -> tensor<7x6x4x5xi8>
    %1 = "tosa.const"() <{values = dense<1.652800e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %0, %2, %3 : (tensor<7x6x4x5xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<7x6x4x5xi8>
    %5 = tosa.arithmetic_right_shift %4, %4 {round = true} : (tensor<7x6x4x5xi8>, tensor<7x6x4x5xi8>) -> tensor<7x6x4x5xi8>
    %6 = tosa.reciprocal %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %5 : tensor<7x6x4x5xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

