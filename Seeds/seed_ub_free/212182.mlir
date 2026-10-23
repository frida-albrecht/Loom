module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<9x8x5x5xi8>}> : () -> tensor<9x8x5x5xi8>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<1x8x5x1xi8>}> : () -> tensor<1x8x5x1xi8>
    %2 = tosa.bitwise_and %0, %1 : (tensor<9x8x5x5xi8>, tensor<1x8x5x1xi8>) -> tensor<9x8x5x5xi8>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<9x8x5x5xi8>) -> tensor<9x1x5x5xi8>
    %cast = tensor.cast %3 : tensor<9x1x5x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

