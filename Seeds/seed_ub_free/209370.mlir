module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<9xi8>}> : () -> tensor<9xi8>
    %1 = "tosa.const"() <{values = dense<-19> : tensor<9xi8>}> : () -> tensor<9xi8>
    %2 = "tosa.const"() <{values = dense<5.266000e+01> : tensor<6x7x9x7xf32>}> : () -> tensor<6x7x9x7xf32>
    %3 = tosa.minimum %0, %1 : (tensor<9xi8>, tensor<9xi8>) -> tensor<9xi8>
    %4 = tosa.tanh %2 : (tensor<6x7x9x7xf32>) -> tensor<6x7x9x7xf32>
    %5 = tosa.reverse %3 {axis = 0 : i32} : (tensor<9xi8>) -> tensor<9xi8>
    %6 = tosa.log %4 : (tensor<6x7x9x7xf32>) -> tensor<6x7x9x7xf32>
    %cast = tensor.cast %5 : tensor<9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<6x7x9x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

