module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<5x1x5x8xi8>}> : () -> tensor<5x1x5x8xi8>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<5x1x5x72xi8>}> : () -> tensor<5x1x5x72xi8>
    %2 = tosa.concat %0, %1 {axis = 3 : i32} : (tensor<5x1x5x8xi8>, tensor<5x1x5x72xi8>) -> tensor<5x1x5x80xi8>
    %cast = tensor.cast %2 : tensor<5x1x5x80xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

