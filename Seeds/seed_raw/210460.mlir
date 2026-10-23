module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<3x5x7xi8>}> : () -> tensor<3x5x7xi8>
    %1 = "tosa.const"() <{values = dense<-19> : tensor<3x15x7xi8>}> : () -> tensor<3x15x7xi8>
    %2 = "tosa.const"() <{values = dense<1.352100e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<3x5x7xi8>, tensor<3x15x7xi8>) -> tensor<3x20x7xi8>
    %4 = tosa.abs %3 : (tensor<3x20x7xi8>) -> tensor<3x20x7xi8>
    %5 = tosa.exp %2 : (tensor<7xf32>) -> tensor<7xf32>
    %6 = tosa.maximum %5, %5 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %4 : tensor<3x20x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

