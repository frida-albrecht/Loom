module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<191> : tensor<7xi16>}> : () -> tensor<7xi16>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<78xi16>}> : () -> tensor<78xi16>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<7xi16>, tensor<78xi16>) -> tensor<85xi16>
    %3 = tosa.bitwise_and %2, %2 : (tensor<85xi16>, tensor<85xi16>) -> tensor<85xi16>
    %cast = tensor.cast %3 : tensor<85xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

