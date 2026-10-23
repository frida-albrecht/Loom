module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<3x2x1xi8>}> : () -> tensor<3x2x1xi8>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<3x1x7xi8>}> : () -> tensor<3x1x7xi8>
    %2 = "tosa.const"() <{values = dense<1.722700e+02> : tensor<5x4x7xf32>}> : () -> tensor<5x4x7xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<3x2x1xi8>, tensor<3x1x7xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<3x2x7xi8>
    %6 = tosa.maximum %5, %5 : (tensor<3x2x7xi8>, tensor<3x2x7xi8>) -> tensor<3x2x7xi8>
    %7 = tosa.log %2 : (tensor<5x4x7xf32>) -> tensor<5x4x7xf32>
    %cast = tensor.cast %6 : tensor<3x2x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<5x4x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

