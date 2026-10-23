module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<9x6x4x6xi8>}> : () -> tensor<9x6x4x6xi8>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<9x6x4x6xi8>) -> tensor<9x1x4x6xi8>
    %2 = tosa.identity %1 : (tensor<9x1x4x6xi8>) -> tensor<9x1x4x6xi8>
    %3 = tosa.identity %2 : (tensor<9x1x4x6xi8>) -> tensor<9x1x4x6xi8>
    %cast = tensor.cast %3 : tensor<9x1x4x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

